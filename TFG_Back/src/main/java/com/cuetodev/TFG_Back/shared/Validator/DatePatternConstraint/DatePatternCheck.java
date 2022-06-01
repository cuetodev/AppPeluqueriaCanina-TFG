package com.cuetodev.TFG_Back.shared.Validator.DatePatternConstraint;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class DatePatternCheck implements
        ConstraintValidator<DatePatternCheckConstraint, String> {

    @Override
    public void initialize(DatePatternCheckConstraint date) {
    }

    @Override
    public boolean isValid(String date, ConstraintValidatorContext constraintValidatorContext) {
        if (date == null) return true;
        return date.matches("\\d{4}-\\d{2}-\\d{2}");
    }

}
