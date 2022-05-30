package com.cuetodev.TFG_Back.shared.Validator.DatePatternConstraint;


import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Documented
@Constraint(validatedBy = DatePatternCheck.class)
@Target( { ElementType.METHOD, ElementType.FIELD })
@Retention(RetentionPolicy.RUNTIME)
public @interface DatePatternCheckConstraint {
    String message() default "Invalid format date please follow this pattern: yyyy-MM-dd";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
