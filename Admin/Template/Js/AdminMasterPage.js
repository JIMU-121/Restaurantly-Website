﻿
const btn = document.querySelector('.mobile-menu-button');
const sidebar = document.querySelector('.side-navbar');
const contentdiv = document.querySelector('.content-container');
const footer = document.querySelector('footer');

const submenu = document.querySelector('.submenu');
const arrow = document.querySelector('.arrow');


/*    Form validation       */
function FormValTextBox(id) {
    if ($("#" + id).val() != "") {
        $("#" + id + "Warning").text("");
    }


}

function FormValDropDown(id) {
    if ($("#" + id).val() != 0) {
        $("#" + id + "Warning").text("");
    }
}
/*     Form validation  End      */



const navbarbtn = (widthSize) => {
    if (widthSize.matches) {

        btn.addEventListener('click', () => {
            sidebar.classList.toggle('-translate-x-full');
            

        })

        

    } else {
        btn.addEventListener('click', () => {
            sidebar.classList.toggle('lg:translate-x-0');
            contentdiv.classList.toggle('lg:ml-72')

        })
        
    }
}






$('.menu').click(function () {

    $(this).children('.submenu').slideToggle();
    // arrow.classList.toggle('rotate-0');
    $(this).children('div').classList.toggle('bg-blue-700');
})


$(function () {
    
    $('.submenu').slideToggle();
    
})

const widthSize = window.matchMedia("(max-width:1024px)");
navbarbtn(widthSize);
widthSize.addEventListener("change", navbarbtn);
