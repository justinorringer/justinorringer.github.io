---
layout: gallery
title: Photography
permalink: /photography/
---

<div class="fullscreen-gallery" oncontextmenu="return false;">
  <div class="gallery-container">
    <div class="gallery-slides" id="gallerySlides">
      <!-- Slides will be dynamically loaded here -->
    </div>
    
    <div class="gallery-navigation">
      <button class="nav-btn prev-btn" id="prevBtn" onclick="changeSlide(-1)">‹</button>
      <button class="nav-btn next-btn" id="nextBtn" onclick="changeSlide(1)">›</button>
    </div>
    
    <div class="gallery-info">
      <div class="slide-counter">
        <span id="currentSlide">1</span> / <span id="totalSlides">13</span>
      </div>
    </div>
  </div>
</div>

<!-- Modal for enlarged images -->
<div id="photoModal" class="modal" onclick="closeModal()">
  <span class="close">&times;</span>
  <img class="modal-content" id="modalImg" ondragstart="return false;" oncontextmenu="return false;">
</div>

<!-- Pass config to JavaScript -->
<script type="application/json" id="gallery-config">
{
  "cloudinary": {
    "base_url": "{{ site.cloudinary.base_url }}"
  }
}
</script>

<script>
// Get configuration from JSON script tag
const galleryConfig = JSON.parse(document.getElementById('gallery-config').textContent);
const baseUrl = galleryConfig.cloudinary.base_url;

// Photography collections data
const collections = [
  {
    title: "Cells",
    description: "Intimate spaces and confined geometries that tell stories of containment and liberation.",
    folder: "cells"
  },
  {
    title: "Displays", 
    description: "Windows into other worlds - screens, reflections, and curated presentations of reality.",
    folder: "displays"
  },
  {
    title: "Aquarian",
    description: "Fluid moments and water's endless dance with light and form.",
    folder: "aquarian"
  },
  {
    title: "AL",
    description: "Personal narratives and intimate documentation of people and places.",
    folder: "al"
  },
  {
    title: "Chrome",
    description: "Reflective surfaces and metallic textures that mirror our industrial surroundings.",
    folder: "chrome"
  },
  {
    title: "Cruise",
    description: "Journey and movement captured in time, exploring themes of travel and transition.",
    folder: "cruise"
  },
  {
    title: "Rich",
    description: "Abundance and texture in both material and emotional landscapes.",
    folder: "rich"
  },
  {
    title: "Horizontal",
    description: "Wide vistas and expansive moments that stretch across the frame.",
    folder: "horizontal"
  },
  {
    title: "Inevitable",
    description: "Moments of certainty and the unstoppable flow of time and change.",
    folder: "inevitable"
  },
  {
    title: "Paint",
    description: "Color, texture, and the materiality of surfaces that tell stories through decay and renewal.",
    folder: "paint"
  },
  {
    title: "People",
    description: "Human connections and the stories written in faces and gestures.",
    folder: "people"
  },
  {
    title: "Produce",
    description: "The beauty of organic forms and the poetry found in everyday sustenance.",
    folder: "produce"
  },
  {
    title: "Tired",
    description: "Worn surfaces and weathered moments that speak to the passage of time.",
    folder: "tired"
  }
];

let currentSlideIndex = 0;

// Disable right-click and drag
document.addEventListener('contextmenu', function(e) {
  if (e.target.tagName === 'IMG') {
    e.preventDefault();
    return false;
  }
});

document.addEventListener('dragstart', function(e) {
  if (e.target.tagName === 'IMG') {
    e.preventDefault();
    return false;
  }
});

// Create slide HTML
function createSlide(collection, index) {
  return `
    <div class="gallery-slide" data-index="${index}">
      <div class="photo-grid">
        <div class="photo-item" onclick="openModal(this)">
          <img data-src="${baseUrl}/w_800,q_auto,f_auto/${collection.folder}/1.jpg" 
               alt="${collection.title} 1" 
               class="lazy-image"
               ondragstart="return false;" 
               oncontextmenu="return false;">
        </div>
        <div class="photo-item" onclick="openModal(this)">
          <img data-src="${baseUrl}/w_800,q_auto,f_auto/${collection.folder}/2.jpg" 
               alt="${collection.title} 2" 
               class="lazy-image"
               ondragstart="return false;" 
               oncontextmenu="return false;">
        </div>
        <div class="photo-item" onclick="openModal(this)">
          <img data-src="${baseUrl}/w_800,q_auto,f_auto/${collection.folder}/3.jpg" 
               alt="${collection.title} 3" 
               class="lazy-image"
               ondragstart="return false;" 
               oncontextmenu="return false;">
        </div>
        <div class="photo-item" onclick="openModal(this)">
          <img data-src="${baseUrl}/w_800,q_auto,f_auto/${collection.folder}/4.jpg" 
               alt="${collection.title} 4" 
               class="lazy-image"
               ondragstart="return false;" 
               oncontextmenu="return false;">
        </div>
      </div>
    </div>
  `;
}

// Initialize gallery
function initGallery() {
  const slidesContainer = document.getElementById('gallerySlides');
  const totalSlides = document.getElementById('totalSlides');
  
  totalSlides.textContent = collections.length;
  
  // Create all slides but don't load images yet
  collections.forEach((collection, index) => {
    slidesContainer.innerHTML += createSlide(collection, index);
  });
  
  // Show first slide
  showSlide(0);
}

// Show specific slide
function showSlide(index) {
  const slides = document.querySelectorAll('.gallery-slide');
  const currentSlideSpan = document.getElementById('currentSlide');
  
  // Hide all slides
  slides.forEach(slide => slide.classList.remove('active'));
  
  // Show current slide
  slides[index].classList.add('active');
  
  // Update counter
  currentSlideSpan.textContent = index + 1;
  
  // Load images for current slide
  loadSlideImages(index);
  
  // Preload next slide
  if (index + 1 < collections.length) {
    loadSlideImages(index + 1);
  }
  
  // Update navigation buttons - use class for visibility to maintain layout
  const prevBtn = document.getElementById('prevBtn');
  const nextBtn = document.getElementById('nextBtn');
  
  if (index === 0) {
    prevBtn.classList.add('hidden');
  } else {
    prevBtn.classList.remove('hidden');
  }
  
  if (index === collections.length - 1) {
    nextBtn.classList.add('hidden');
  } else {
    nextBtn.classList.remove('hidden');
  }
}

// Load images for a specific slide
function loadSlideImages(slideIndex) {
  const slide = document.querySelector(`[data-index="${slideIndex}"]`);
  const lazyImages = slide.querySelectorAll('.lazy-image');
  
  lazyImages.forEach(img => {
    if (!img.src && img.dataset.src) {
      img.src = img.dataset.src;
      img.classList.add('loaded');
    }
  });
}

// Change slide
function changeSlide(direction) {
  const newIndex = currentSlideIndex + direction;
  
  if (newIndex >= 0 && newIndex < collections.length) {
    currentSlideIndex = newIndex;
    showSlide(currentSlideIndex);
  }
}

// Touch/swipe handling
let touchStartX = 0;
let touchEndX = 0;

function handleSwipe() {
  const swipeThreshold = 50;
  const swipeDistance = touchEndX - touchStartX;
  
  if (Math.abs(swipeDistance) > swipeThreshold) {
    if (swipeDistance > 0) {
      changeSlide(-1); // Swipe right = previous
    } else {
      changeSlide(1);  // Swipe left = next
    }
  }
}

// Event listeners
document.addEventListener('touchstart', e => {
  touchStartX = e.changedTouches[0].screenX;
});

document.addEventListener('touchend', e => {
  touchEndX = e.changedTouches[0].screenX;
  handleSwipe();
});

// Keyboard navigation
document.addEventListener('keydown', e => {
  if (e.key === 'ArrowLeft') changeSlide(-1);
  if (e.key === 'ArrowRight') changeSlide(1);
  if (e.key === 'Escape') closeModal();
});

// Modal functionality
function openModal(element) {
  const modal = document.getElementById('photoModal');
  const modalImg = document.getElementById('modalImg');
  const caption = document.getElementById('caption');
  const img = element.querySelector('img');
  
  modal.style.display = 'block';
  
  // Load a larger version for the modal
  const largeSrc = img.src.replace('/w_800,q_auto,f_auto/', '/w_1600,q_auto,f_auto/');
  modalImg.src = largeSrc;
  caption.innerHTML = img.alt;
}

function closeModal() {
  document.getElementById('photoModal').style.display = 'none';
}

// Initialize when page loads
document.addEventListener('DOMContentLoaded', initGallery);
</script>
