import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  final List<String> options;
  final int? selectedOption; // index jawaban yang dipilih
  final Function(int) onOptionSelected;

  const QuestionCard({
    super.key,
    required this.question,
    required this.options,
    required this.onOptionSelected,
    this.selectedOption,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pertanyaan
            Text(
              question,
              style: TextStyle(
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2575FC),
              ),
            ),
            const SizedBox(height: 15),

            // Opsi jawaban
            ...List.generate(
              options.length,
              (i) {
                final isSelected = selectedOption == i;
                return GestureDetector(
                  onTap: () => onOptionSelected(i),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF6A11CB).withOpacity(0.1)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF6A11CB)
                            : Colors.grey[300]!,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Titik di kiri
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected ? const Color(0xFF6A11CB) : Colors.transparent,
                            border: Border.all(color: const Color(0xFF6A11CB)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            options[i],
                            style: TextStyle(
                              fontSize: size.width * 0.04,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
