$(document).ready(function (e) {
    $("span.validation-error").attrchange({
        trackValues: false, /* Default to false, if set to true the event object is 
				updated with old and new value.*/
        callback: function (event) {
            var controlToValidate = $("#" + this.controltovalidate);
            var validators = controlToValidate.prop('Validators');

            if (validators == null) return;

            var isValid = true;
            $(validators).each(function () {
                if (this.isvalid !== true) {
                    isValid = false;
                }
            });

            if (isValid) {
                $(controlToValidate).closest('.form-group').removeClass("has-error");
            }
            else {
                $(controlToValidate).closest('.form-group').addClass("has-error");
            }

            //event    	          - event object
            //event.attributeName - Name of the attribute modified
            //event.oldValue      - Previous value of the modified attribute
            //event.newValue      - New value of the modified attribute
            //Triggered when the selected elements attribute is added/updated/removed
        }
    });
});