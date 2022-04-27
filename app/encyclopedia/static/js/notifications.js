function close_alert(vent) {
    let el = document.querySelector('.alert');
    el.style.display = 'none';
}

let closebtn = document.querySelector('.closebtn');
let closeontimeout = setTimeout(close_alert, 10000);
let prolongtimeout = () => {
    clearTimeout(closeontimeout);
    closeontimeout = setTimeout(close_alert, 10000);
}
