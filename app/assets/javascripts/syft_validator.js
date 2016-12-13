(function($){
    $.fn.syftValidator = function(){
        this.submit(function(e){
            var validToSubmit = true;
            $(this).find('input, select').each(function(){
                if($(this).attr('data-required') && !$(this).val()){
                    $(this).parents('.input-validate-message-area').find('.helper-text').remove();
                    if($(this).attr('data-message')){
                        $(this).parents('.input-validate-message-area').append('<p class="helper-text" style="color: red">'+ $(this).attr('data-message') + '*' +'</p>')
                    }
                    else{
                        $(this).parents('.input-validate-message-area').append('<p class="helper-text" style="color: red"> This field is required* </p>')
                    }
                    validToSubmit = false;
                }
                else{
                    $(this).parents('.input-validate-message-area').find('.helper-text').remove();
                }
            });
            if(!validToSubmit){
                e.preventDefault();
                e.stopPropagation();
            };
        });
        return this;
    };
}(jQuery));
