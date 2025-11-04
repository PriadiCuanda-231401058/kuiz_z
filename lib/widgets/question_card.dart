import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  final List<String> options;
  final int? selectedOption;
  final Function(int) onOptionSelected;

  const QuestionCard({
    super.key,
    required this.question,
    required this.options,
    required this.selectedOption,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait = size.height > size.width;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isPortrait ? 1 : 2,
        crossAxisSpacing: isPortrait ? 12 : 8,
        mainAxisSpacing: isPortrait ? 12 : 8,
        childAspectRatio: isPortrait ? 5 : 3.5, // Disesuaikan untuk landscape
      ),
      itemCount: options.length,
      itemBuilder: (context, index) {
        return _buildOptionItem(context, index, options[index], size, isPortrait);
      },
    );
  }

  Widget _buildOptionItem(BuildContext context, int index, String option, Size size, bool isPortrait) {
    final isSelected = selectedOption == index;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onOptionSelected(index),
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isPortrait ? size.width * 0.04 : size.width * 0.02,
              vertical: isPortrait ? size.height * 0.02 : size.height * 0.015,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.15)
                  : Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey.withOpacity(0.3),
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: isPortrait ? size.width * 0.06 : size.width * 0.04,
                  height: isPortrait ? size.width * 0.06 : size.width * 0.04,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      String.fromCharCode(65 + index), // A, B, C, D
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: isPortrait ? size.width * 0.035 : size.width * 0.025,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.grey[700],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: isPortrait ? 12 : 8),
                Expanded(
                  child: Text(
                    option,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: isPortrait ? size.width * 0.038 : size.width * 0.025,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle_rounded,
                    color: Theme.of(context).colorScheme.primary,
                    size: isPortrait ? size.width * 0.05 : size.width * 0.035,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}