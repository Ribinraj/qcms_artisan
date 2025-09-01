import 'package:flutter/material.dart';

import 'package:qcms_artisan/core/colors.dart';

class DropdownItem {
  final String id;
  final String display;
  
  DropdownItem({required this.id, required this.display});
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DropdownItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class CustomSearchDropdown extends StatefulWidget {
  final DropdownItem? value;
  final String hintText;
  final List<DropdownItem> items;
  final void Function(DropdownItem?)? onChanged;
  final String? Function(DropdownItem?)? validator;
  final FocusNode? focusNode;
  final bool enableSearch;
  final String searchHintText;

  const CustomSearchDropdown({
    super.key,
    this.value,
    required this.hintText,
    required this.items,
    this.onChanged,
    this.validator,
    this.focusNode,
    this.enableSearch = false,
    this.searchHintText = "Search...",
  });

  @override
  State<CustomSearchDropdown> createState() => _CustomSearchDropdownState();
}

class _CustomSearchDropdownState extends State<CustomSearchDropdown> {
  bool _isOpen = false;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  final TextEditingController _searchController = TextEditingController();
  List<DropdownItem> _filteredItems = [];
  final FocusNode _searchFocusNode = FocusNode();
  bool _disposed = false;
  
  // Static variable to keep track of currently open dropdown
  static _CustomSearchDropdownState? _currentOpenDropdown;

  @override
  void initState() {
    super.initState();
    _updateFilteredItems();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void didUpdateWidget(CustomSearchDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_disposed && mounted) {
          _updateFilteredItems();
        }
      });
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _closeDropdown();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchFocusNode.dispose();
    
    // Clear static reference if this is the currently open dropdown
    if (_currentOpenDropdown == this) {
      _currentOpenDropdown = null;
    }
    
    super.dispose();
  }

  bool get _canPerformOperations => !_disposed && mounted;

  void _updateFilteredItems() {
    if (_canPerformOperations) {
      setState(() {
        _filteredItems = List.from(widget.items);
      });
    }
  }

  void _onSearchChanged() {
    _filterItems(_searchController.text);
  }

  void _filterItems(String query) {
    if (!_canPerformOperations) return;

    final filtered = query.trim().isEmpty
        ? List<DropdownItem>.from(widget.items)
        : widget.items.where((item) {
            return item.display.toLowerCase().contains(query.trim().toLowerCase());
          }).toList();

    setState(() {
      _filteredItems = filtered;
    });
    
    // Safely update overlay
    if (_isOpen && _overlayEntry != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_canPerformOperations && _overlayEntry != null) {
          try {
            _overlayEntry!.markNeedsBuild();
          } catch (e) {
            // Ignore errors when overlay is being disposed
          }
        }
      });
    }
  }

  void _toggleDropdown() {
    if (!_canPerformOperations) return;
    
    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    if (widget.items.isEmpty || !_canPerformOperations) return;
    
    try {
      // Close any other open dropdown first
      _currentOpenDropdown?._closeDropdown();
      
      // Reset search and filter
      _searchController.clear();
      _filterItems('');
      
      final renderBox = context.findRenderObject() as RenderBox?;
      if (renderBox == null || !renderBox.hasSize) return;
      
      _overlayEntry = _createOverlayEntry();
      if (_overlayEntry != null) {
        Overlay.of(context).insert(_overlayEntry!);
        
        if (_canPerformOperations) {
          setState(() {
            _isOpen = true;
            _currentOpenDropdown = this; // Set this as the currently open dropdown
          });

          // REMOVED: Auto focus search field to prevent automatic keyboard
          // The keyboard will only appear when user manually taps the search field
        }
      }
    } catch (e) {
      // Handle any errors during dropdown opening
      _closeDropdown();
    }
  }

  void _closeDropdown() {
    if (_overlayEntry != null) {
      try {
        _overlayEntry!.remove();
      } catch (e) {
        // Ignore errors when removing overlay
      } finally {
        _overlayEntry = null;
      }
    }
    
    // Unfocus search field to hide keyboard
    if (_searchFocusNode.hasFocus) {
      _searchFocusNode.unfocus();
    }
    
    if (_canPerformOperations) {
      setState(() {
        _isOpen = false;
      });
    }
    
    // Clear static reference if this is the currently open dropdown
    if (_currentOpenDropdown == this) {
      _currentOpenDropdown = null;
    }
  }

  void _clearSearch() {
    _searchController.clear();
    _filterItems('');
  }

  OverlayEntry? _createOverlayEntry() {
    if (!_canPerformOperations) return null;
    
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return null;
    
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => GestureDetector(
        // This will detect taps outside the dropdown
        onTap: () => _closeDropdown(),
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            // Invisible full-screen overlay to catch outside taps
            Positioned.fill(
              child: Container(
                color: Colors.transparent,
              ),
            ),
            // The actual dropdown
            Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, size.height + 2),
                child: GestureDetector(
                  // Prevent the dropdown itself from closing when tapped
                  onTap: () {},
                  child: Material(
                    elevation: 8.0,
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: widget.enableSearch ? 280 : 200,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey.shade300, width: 1.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Search field
                          if (widget.enableSearch) ...[
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.shade200,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: TextField(
                                controller: _searchController,
                                focusNode: _searchFocusNode,
                                // REMOVED: autofocus: true to prevent automatic keyboard
                                decoration: InputDecoration(
                                  hintText: widget.searchHintText,
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 14,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey.shade500,
                                    size: 18,
                                  ),
                                  suffixIcon: _searchController.text.isNotEmpty
                                      ? GestureDetector(
                                          onTap: _clearSearch,
                                          child: Icon(
                                            Icons.clear,
                                            color: Colors.grey.shade500,
                                            size: 18,
                                          ),
                                        )
                                      : null,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                    borderSide: BorderSide(color: Colors.grey.shade300),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                    borderSide: BorderSide(color: Appcolors.kprimaryColor, width: 2),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 10.0,
                                  ),
                                  isDense: true,
                                ),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                          // Dropdown items list
                          Flexible(
                            child: _filteredItems.isEmpty
                                ? Container(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.search_off,
                                          color: Colors.grey.shade400,
                                          size: 32,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          widget.enableSearch && _searchController.text.isNotEmpty
                                              ? "No results found"
                                              : "No items available",
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: _filteredItems.length,
                                    itemBuilder: (context, index) {
                                      final item = _filteredItems[index];
                                      final searchQuery = _searchController.text.trim();
                                      
                                      return InkWell(
                                        onTap: () {
                                          if (_canPerformOperations) {
                                            widget.onChanged?.call(item);
                                            _closeDropdown();
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 14,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: index < _filteredItems.length - 1
                                                ? Border(
                                                    bottom: BorderSide(
                                                      color: Colors.grey.shade100,
                                                      width: 1.0,
                                                    ),
                                                  )
                                                : null,
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: _buildHighlightedText(item.display, searchQuery),
                                              ),
                                              if (widget.value == item)
                                                Icon(
                                                  Icons.check,
                                                  color: Appcolors.kprimaryColor,
                                                  size: 16,
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightedText(String text, String query) {
    if (query.isEmpty || !widget.enableSearch) {
      return Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black87,
        ),
      );
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final index = lowerText.indexOf(lowerQuery);

    if (index == -1) {
      return Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black87,
        ),
      );
    }

    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black87,
        ),
        children: [
          if (index > 0)
            TextSpan(text: text.substring(0, index)),
          TextSpan(
            text: text.substring(index, index + query.length),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              backgroundColor: Appcolors.kprimaryColor.withOpacity(0.2),
              color: Appcolors.kprimaryColor,
            ),
          ),
          if (index + query.length < text.length)
            TextSpan(text: text.substring(index + query.length)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_canPerformOperations) {
      return SizedBox.shrink();
    }

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFE8E4F3),
            border: Border(
              bottom: BorderSide(color: Appcolors.ksecondaryColor, width: 1.5),
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.value?.display ?? widget.hintText,
                    style: TextStyle(
                      fontSize: widget.value != null ? 16 : 15,
                      color: widget.value != null
                          ? Colors.black87
                          : Colors.grey.shade600,
                      fontWeight: widget.value != null 
                          ? FontWeight.w500 
                          : FontWeight.normal,
                    ),
                  ),
                ),
                AnimatedRotation(
                  duration: const Duration(milliseconds: 200),
                  turns: _isOpen ? 0.5 : 0,
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}