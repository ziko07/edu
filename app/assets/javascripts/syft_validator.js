function dataRequired(scopeArea){
    return scopeArea.val();
}


(function($){
    $.fn.syftValidator = function(){



        var validatingkeys = ['data-required'];
        var validateCheckingKeys = {
            'data-required': 'dataRequired'
        }

        var validationMessage = {
            'data-required': "Can't be blank"
        }

        function attrMaker(){
            var attrs = "";
            $.each(validatingkeys,function(key, value){
                if (key == 0){
                    attrs += '['+ value + ']';
                }
                else{
                    attrs += ', ['+ value + ']';
                }
            });
            return attrs;
        }

        function removeExistingMessage(scopeArea){
            scopeArea.parents('.input-validate-message-area').find('.helper-text').remove();
            scopeArea.next('.helper-text').remove();
        }

        function dataMessageElementGenerator(message){
            return "<p class='helper-text' style='color: red;'>"+ message +"</p>";
        }

        function dataMessage(scopeArea, rule){
            return scopeArea.attr('data-message') ? dataMessageElementGenerator(scopeArea.attr('data-message')) : dataMessageElementGenerator( validationMessage[rule]);
        }

        function putMessage(scopeArea, message, operation){
            if(operation){
                scopeArea.append(message);
            }
            else{
                scopeArea.after(message);
                console.log(scopeArea);
            }
        }

        function checkMessageArea(scopeArea){
            return scopeArea.parents('.input-validate-message-area');
        }

        function validatingRules(scopeArea){
            var validateFiled = false;
            $.each(validatingkeys, function(key, value){
                if(scopeArea.attr(value) && !window[validateCheckingKeys[value]](scopeArea)){
                    removeExistingMessage(scopeArea);
                    checkMessageArea(scopeArea).length > 0 ? putMessage(checkMessageArea(scopeArea), dataMessage(scopeArea, value), true) : putMessage(scopeArea, dataMessage(scopeArea, value), false);
                    validateFiled = true;
                }
            });

            return validateFiled;
        }

        function isValidForSubmit(scopeArea){
            var isValid = true;
            scopeArea.find(attrMaker()).each(function(){
                if(validatingRules($(this))){
                    isValid = false
                }
                else{
                    removeExistingMessage($(this));
                }
            });
            return isValid;
        }

        this.submit(function(e){

            if(!isValidForSubmit($(this))){
                e.preventDefault();
                e.stopPropagation();
            };
        });
        return this;
    };
}(jQuery));
