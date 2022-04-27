function sub(obj) {
    let file = obj.value;
    let fileName = file.split("\\");
    let filespan = document.querySelector('.filename');
    filespan.innerHTML = 'Uploaded file: ' + fileName[fileName.length - 1]; 

}