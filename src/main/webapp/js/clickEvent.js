function clickEvent(event) {
    clearError();
    let isValid = false;
    $('.active').each(function () {
        isValid = true;
    });
    if (!isValid) {
        showMessage("Значение R не выбрано");
        return false;
    } else {
        let r = document.getElementsByClassName("active")[0].value;
        let coordX = event.pageX - $("#graph").offset().left;
        let coordY = event.pageY - $("#graph").offset().top;
        let x = (coordX - 200) / 150 * r;
        let y = (200 - coordY) / 150 * r;
        sendRequest(x, y, r);
    }
}