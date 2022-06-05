function gotop() {
    bodyst = document.body.scrollTop;
    htmlst = document.documentElement.scrollTop;

    if (bodyst > 0 || htmlst > 0) 
        document.querySelector('.go-top').style.opacity = 1;
    else 
        document.querySelector('.go-top').style.opacity = 0;
}


