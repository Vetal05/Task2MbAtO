import 'package:flutter/material.dart';
import 'dart:async';
import '../../domain/entities/ukraine_city.dart';
import '../../data/services/openweather_geocoding_service.dart';

class CitySearchWidget extends StatefulWidget {
  final Function(UkraineCity) onCitySelected;
  final UkraineCity? selectedCity;

  const CitySearchWidget({
    super.key,
    required this.onCitySelected,
    this.selectedCity,
  });

  @override
  State<CitySearchWidget> createState() => _CitySearchWidgetState();
}

class _CitySearchWidgetState extends State<CitySearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  List<UkraineCity> _searchResults = [];
  bool _isSearching = false;
  bool _showResults = false;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    if (widget.selectedCity != null) {
      _searchController.text = widget.selectedCity!.name;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();

    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _showResults = false;
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _showResults = true;
    });

    // Debounce пошуку, щоб уникнути занадто багатьох API викликів
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      try {
        final results = await OpenWeatherGeocodingService.searchLocations(
          query,
        );
        if (mounted) {
          setState(() {
            _searchResults = results;
            _isSearching = false;
          });
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _searchResults = [];
            _isSearching = false;
          });
        }
      }
    });
  }

  void _onCitySelected(UkraineCity city) {
    setState(() {
      _searchController.text = city.name;
      _showResults = false;
    });
    widget.onCitySelected(city);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Поле пошуку
        TextField(
          controller: _searchController,
          focusNode: _searchFocusNode,
          onChanged: _onSearchChanged,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Введіть назву міста, села або селища...',
            hintStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
            prefixIcon: Icon(Icons.search, color: Colors.grey.withOpacity(0.7)),
            suffixIcon:
                _searchController.text.isNotEmpty
                    ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Colors.grey.withOpacity(0.7),
                      ),
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          _searchResults = [];
                          _showResults = false;
                        });
                      },
                    )
                    : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Результати пошуку
        if (_showResults)
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D2D),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
            ),
            child:
                _isSearching
                    ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.yellow,
                          ),
                        ),
                      ),
                    )
                    : _searchResults.isEmpty
                    ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Населений пункт не знайдено',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                    : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final city = _searchResults[index];
                        return ListTile(
                          leading: const Icon(
                            Icons.location_city,
                            color: Colors.yellow,
                            size: 20,
                          ),
                          title: Text(
                            city.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            city.region,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          onTap: () => _onCitySelected(city),
                          hoverColor: Colors.grey.withOpacity(0.1),
                        );
                      },
                    ),
          ),
      ],
    );
  }
}
