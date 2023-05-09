import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Sample2 extends StatelessWidget {
  const Sample2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        child: FancyPasswordField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.lock),
            border: OutlineInputBorder(),
            hintText: 'Password',
          ),
          validationRules: {
            UppercaseValidationRule(),
            LowercaseValidationRule(),
            DigitValidationRule(),
            SpecialCharacterValidationRule(),
            MinCharactersValidationRule(6),
          },
          strengthIndicatorBuilder: (strength) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: StepProgressIndicator(
                totalSteps: 8,
                currentStep: getStep(strength),
                selectedColor: getColor(strength)!,
                unselectedColor: Colors.grey[300]!,
              ),
            );
          },
          validationRuleBuilder: (rules, value) {
            return ListView(
              shrinkWrap: true,
              children: rules.map(
                    (rule) {
                  final ruleValidated = rule.validate(value);
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        ruleValidated ? Icons.check : Icons.close,
                        color: ruleValidated ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        rule.name,
                        style: TextStyle(
                          color: ruleValidated ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  );
                },
              ).toList(),
            );
          },
        ),
      ),
    );
  }

  int getStep(double strength) {
    if (strength == 0) {
      return 0;
    } else if (strength < .1) {
      return 1;
    } else if (strength < .2) {
      return 2;
    } else if (strength < .3) {
      return 3;
    } else if (strength < .4) {
      return 4;
    } else if (strength < .5) {
      return 5;
    } else if (strength < .6) {
      return 6;
    } else if (strength < .7) {
      return 7;
    }
    return 8;
  }

  Color? getColor(double strength) {
    if (strength == 0) {
      return Colors.grey[300];
    } else if (strength < .1) {
      return Colors.red;
    } else if (strength < .2) {
      return Colors.red;
    } else if (strength < .3) {
      return Colors.yellow;
    } else if (strength < .4) {
      return Colors.yellow;
    } else if (strength < .5) {
      return Colors.yellow;
    } else if (strength < .6) {
      return Colors.green;
    } else if (strength < .7) {
      return Colors.green;
    }
    return Colors.green;
  }
}