let show_modal = function(codeid) {
    return function curried(e) {
        element = document.querySelector(codeid);
        element.classList.toggle('modal-displayed') ;
    }
}

function close_modal(event) {
    let el = document.querySelector('.modal-displayed').children[0];
    closebtn = el.children[0].children[1];
    // console.log(document.querySelector('.modal-displayed').children);
    if (closebtn.contains(event.target) || !el.contains(event.target))
        document.querySelector('.modal-displayed').classList.toggle('modal-displayed');
}

function copy() {
    let exportcode = document.querySelector('.modal-displayed').children[0].children[1];
    exportcode.select();
    exportcode.setSelectionRange(0, 99999); /* For mobile devices */

    navigator.clipboard.writeText(exportcode.value);
}

let maximabtn = document.querySelector('#maximabtn'),
    mathematicabtn = document.querySelector('#mathematicabtn');
    latexbtn = document.querySelector('#latexbtn');

maximabtn.addEventListener('click', show_modal('#maximacode'));
mathematicabtn.addEventListener('click', show_modal('#mathematicacode'));
latexbtn.addEventListener('click', show_modal('#latexcode'));

window.addEventListener("keydown", (e)=> {
    let active_modal = document.getElementsByClassName('modal-displayed')[0]
    if (e.key == 'Escape' && active_modal)
    active_modal.classList.toggle('modal-displayed');
        
    // console.log(typeof(e.key));
})
