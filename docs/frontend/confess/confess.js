document.addEventListener('click', (e) => {
  if (e.target.classList && e.target.classList.contains('head')) {
    document.querySelector('.pin._head').style.opacity = '1';
  } else if (e.target.classList && e.target.classList.contains('body')) {
    document.querySelector('.pin._body').style.opacity = '1';
  } else if (e.target.classList && e.target.classList.contains('foot')) {
    document.querySelector('.pin._foot').style.opacity = '1';
  }
});
