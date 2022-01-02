let x;
let y;
let r;
function checkY() {
    let yField = $('#y-text');
    let yVal = yField.val().replace(',', '.');
    if (yVal === "") {
        showMessage("Значение Y не введено")
        return false;
    } else if (yVal.match(/^[+-]0$/) || yVal.match(/^[+-]0\.0+$/) || yVal.match(/^[+-]?00+$/) || yVal.match(/^[+-]?00+\.[0-9]+$/) ||
        !yVal.match(/^-?[0-9]+\.[0-9]+$/) && !yVal.match(/^-?[0-9]+$/)) {
        showMessage("Значение Y должно быть числом");
        return false;
    }
    if (yVal <= -3 || yVal >= 5) {
        showMessage("Значение Y не входит в интервал (-3,5)");
        return false;
    }
    y = yVal;
    return true;
}

function checkX() {
    let xVal = $('#x-select').val();
    if (!xVal) {
        showMessage("Значение X не выбрано")
        return false;
    }
    x = xVal;
    return true;

}

function checkR() {
    let isValid = false;
    $('.active').each(function () {
        isValid = true;
    });
    if (!isValid) {
        showMessage("Значение R не выбрано");
        return false;
    }
    r = document.getElementsByClassName("active")[0].value;
    return true;
}

function checkForm() {
    let xValid = checkX();
    let yValid = checkY();
    let rValid = checkR();
    return xValid && yValid && rValid;
}

function showMessage(message) {
    let errorMessage = document.createElement("div");
    errorMessage.textContent = message;
    $('#errors').append(errorMessage);
}

function clearError() {
    $('#errors').empty();
}

$('#reset').click(function () {
    $('#errors').empty();
    $('#r :button').removeClass("active");
})

function sendRequest(xVal, yVal, rVal) {
    $.ajax({
        url: "./controller",
        type: 'POST',
        data: {'X': xVal, 'Y': yVal, 'R': rVal},
        success: function (data) {
            window.location.reload(true);
        },
        error: function (response) {
            alert("error: " + response);
        }
    })
}
$('#main-form').on('submit', function (event) {
    event.preventDefault();
    clearError();
    if (checkForm()) {
        sendRequest(x, y, r);
    }
})


