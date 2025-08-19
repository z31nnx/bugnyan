document.addEventListener('click', () => {
  const iframe = document.getElementById('tarot-audio');
  if (!iframe) return;

  // Unmute YouTube player iframe on first click (needed for autoplay)
  iframe.contentWindow.postMessage('{"event":"command","func":"unMute","args":""}', '*');
}, { once: true });

document.addEventListener('DOMContentLoaded', () => {
  const carousel = document.querySelector('.carousel');
  const cards = document.querySelectorAll('.card');
  const prevBtn = document.querySelector('.prev-btn');
  const nextBtn = document.querySelector('.next-btn');

  let currentIndex = 0;
  const totalCards = cards.length;
  const theta = (2 * Math.PI) / totalCards;
  const radius = 400;

  function updateCards() {
    cards.forEach(card => card.classList.remove('active'));
    document.querySelector(`#card-${currentIndex}`).classList.add('active');
  }

  function arrangeCards() {
    cards.forEach((card, index) => {
      const angle = theta * index;
      card.style.transform = `translateX(-50%) rotateY(${angle}rad) translateZ(${radius}px)`;
    });
    carousel.style.transform = `translateZ(-${radius}px) rotateY(${-currentIndex * theta}rad)`;
    updateCards();
  }

  arrangeCards();

  prevBtn.addEventListener('click', () => {
    currentIndex = (currentIndex - 1 + totalCards) % totalCards;
    arrangeCards();
  });

  nextBtn.addEventListener('click', () => {
    currentIndex = (currentIndex + 1) % totalCards;
    arrangeCards();
  });

  cards.forEach((card, index) => {
    card.addEventListener('click', () => {
      currentIndex = index;
      arrangeCards();
      card.classList.toggle('flipped');  // Flip on click
    });
  });
});

// App navigation icons
document.querySelectorAll('.app-icon').forEach(icon => {
  icon.addEventListener('click', () => {
    const app = icon.dataset.app;
    document.querySelectorAll('.app-screen').forEach(screen => screen.style.display = 'none');
    document.getElementById('home-screen').style.display = 'none';
    document.getElementById(`${app}-app`).style.display = 'block';
  });
});

document.getElementById('close-button-main').addEventListener('click', () => {
  document.querySelectorAll('.app-screen').forEach(screen => screen.style.display = 'none');
  document.getElementById('home-screen').style.display = 'flex';
});
