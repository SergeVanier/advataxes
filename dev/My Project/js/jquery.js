
            
            function unloadJS(scriptName) {
                var head = document.getElementsByTagName('head').item(0);
                var js = document.getElementById(scriptName);
                js.parentNode.removeChild(js);
            }

            function unloadAllJS() {
                var jsArray = new Array();
                jsArray = document.getElementsByTagName('script');
                for (i = 0; i < jsArray.length; i++) {
                    if (jsArray[i].id) {
                        unloadJS(jsArray[i].id)
                    } else {
                        jsArray[i].parentNode.removeChild(jsArray[i]);
                    }
                }
            }

            jQuery.fn.forceNumeric = function () {
                return this.each(function () {
                    $(this).keydown(function (e) {

                        var key = e.which || e.keyCode;
                        
                        if (!e.shiftKey && !e.altKey && !e.ctrlKey &&
                        // numbers   
                         key >= 48 && key <= 57 ||
                        // Numeric keypad
                         key >= 96 && key <= 105 ||
                        // comma, period and minus, . on keypad
                        key == 190 || key == 109 || key == 110 ||
                        // Backspace and Tab and Enter
                        key == 8 || key == 9 || key == 13 ||
                        // Home and End
                        key == 35 || key == 36 ||
                        // left and right arrows
                        key == 37 || key == 39 ||
                        // Del and Ins
                        key == 46 || key == 45)
                            return true;

                        return false;
                    });
                });
            }


            jQuery.fn.forceNumericNoDecimal = function () {
                return this.each(function () {
                    $(this).keydown(function (e) {
                        
                        var key = e.which || e.keyCode;
                        
                        if (!e.shiftKey && !e.altKey && !e.ctrlKey &&
                        // numbers   
                         key >= 48 && key <= 57 ||
                        // Numeric keypad
                         key >= 96 && key <= 105 ||
                        // comma, period and minus, . on keypad
                         key == 190 || key == 109 ||
                        // Backspace and Tab and Enter
                        key == 8 || key == 9 || key == 13 ||
                        // Home and End
                        key == 35 || key == 36 ||
                        // left and right arrows
                        key == 37 || key == 39 ||
                        // Del and Ins
                        key == 46 || key == 45)
                            return true;

                        return false;
                    });
                });
            }





            $(document).ready(function () {
                $(".numberinput").forceNumeric();
                $(".numberinput-nodecimal").forceNumericNoDecimal();

                $(".numberinput").blur(function () {
                    var num = $(this).val() * 1;
                    $(this).val(num.toFixed(2));
                });



            });