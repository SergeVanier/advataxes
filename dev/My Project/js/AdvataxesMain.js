function popup(url) {
    var iMyWidth;
    var iMyHeight;
    //half the screen width minus half the new window width (plus 5 pixel borders).
    iMyWidth = (window.screen.width / 2) - (500 + 10);
    //half the screen height minus half the new window height (plus title and status bars).
    iMyHeight = (window.screen.height / 2) - (300 + 50);
    //Open the window.

    var popupWindow = window.open(url, 'popUpWindow', "status=no,height=600,width=1000,resizable=yes,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=yes,location=no,directories=no");
    popupWindow.focus();
}

function promptReason(okFunc, dialogTitle) {
    $('<div style="padding: 10px; max-width: 500px; word-wrap: break-word;"><textarea id="txtReason" cols="40" rows="5" /></div>').dialog({
        draggable: false,
        modal: true,
        resizable: false,
        width: '400',
        title: dialogTitle || 'Reason',
        minHeight: 75,
        buttons: {
            OK: function () {
                if (typeof (okFunc) == 'function') { setTimeout(okFunc, 50); }
                $(this).dialog('destroy');
            }
        }
    });
}

function myMsg(dialogText, okFunc, dialogTitle) {
    $('<div style="padding: 10px; max-width: 500px; word-wrap: break-word;"><span class="labelText" style="font-size:0.9em;">' + dialogText + '</span></div>').dialog({
        draggable: false,
        modal: true,
        resizable: false,
        width: 400,
        title: dialogTitle || 'Message',
        minHeight: 75,
        buttons: {
            OK: function () {
                if (typeof (okFunc) == 'function') { setTimeout(okFunc, 50); }
                $(this).dialog('destroy');
            }
        }
    });
}

function getQuerystring(key, default_) {
    if (default_ == null) default_ = "";
    key = key.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
    var regex = new RegExp("[\\?&]" + key + "=([^&#]*)");
    var qs = regex.exec(window.location.href);
    if (qs == null)
        return default_;
    else
        return qs[1];
}

function showProcessing() {
    var mpe = $find('modalProcessing');
    if (mpe) { mpe.show(); }
}

function guidelines(guidelineSteps) {
    if (guidelineSteps) {
        var tour = new Tourist.Tour({
            steps: guidelineSteps,
            tipClass: 'Bootstrap',
            tipOptions: { showEffect: 'slidein' }
        });

        tour.start();
        return tour;
    }
}