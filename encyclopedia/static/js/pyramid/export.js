let show_modal = function(modal_window_id) {
    modal = document.querySelector(modal_window_id);
    modal.classList.toggle('modal-displayed');
}

function close_modal(event) {
    let el = document.querySelector('.modal-displayed').children[0];
    closebtn = el.children[0].children[1];
    cancelbtn = el.querySelector('#cancel');
    // console.log(document.querySelector('.modal-displayed').children);
    if (closebtn.contains(event.target) || cancelbtn.contains(event.target) || !el.contains(event.target))
        document.querySelector('.modal-displayed').classList.toggle('modal-displayed');
}

function copy() {
    let exportcode = document.querySelector('.modal-displayed').children[0].children[1];
    exportcode.select();
    exportcode.setSelectionRange(0, 99999); /* For mobile devices */

    navigator.clipboard.writeText(exportcode.value);
}

window.addEventListener("keydown", (e)=> {
    let active_modal = document.getElementsByClassName('modal-displayed')[0]
    if (e.key == 'Escape' && active_modal)
    active_modal.classList.toggle('modal-displayed');
        
    // console.log(typeof(e.key));
})
