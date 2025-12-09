---
layout: page
title: Contact
permalink: /contact/
---

<div class="contact-container">
  <div class="contact-intro">
    <p>Let's connect and create something together. Whether it's about photography, development, music, or games.</p>
  </div>

  <div class="contact-grid">
    <div class="contact-info">
      <h2>Get in Touch</h2>
      
      <div class="contact-details">
        <div class="contact-item">
          <h3>Email</h3>
          <p><a href="mailto:{{ site.email }}">{{ site.email }}</a></p>
        </div>
        
        <div class="contact-item">
          <h3>Location</h3>
          <p>{{ site.location }}</p>
        </div>
        
        <div class="contact-item">
          <h3>Resume</h3>
          <p><a href="{{ '/assets/resume.pdf' | relative_url }}" target="_blank" rel="noopener">View Resume (PDF)</a></p>
        </div>
      </div>

      <div class="social-links">
        <h3>Connect Online</h3>
        <div class="social-grid">
          <a href="https://github.com/{{ site.github_username }}" target="_blank" rel="noopener" class="social-link github">
            <span>GitHub</span>
            <small>@{{ site.github_username }}</small>
          </a>
          
          <a href="https://linkedin.com/in/{{ site.linkedin_username }}" target="_blank" rel="noopener" class="social-link linkedin">
            <span>LinkedIn</span>
            <small>Professional Network</small>
          </a>
          
          <a href="https://instagram.com/{{ site.instagram_username }}" target="_blank" rel="noopener" class="social-link instagram">
            <span>Instagram</span>
            <small>@{{ site.instagram_username }}</small>
          </a>
        </div>
      </div>
    </div>

    <div class="contact-form-container">
      <h2>Send a Message</h2>
      
      <!-- Status message container -->
      <div id="form-status" class="form-status" style="display: none;"></div>
      
      <!-- Using Formspree for form handling (works with GitHub Pages) -->
      <form id="contact-form" action="https://formspree.io/f/xjknelyq" method="POST" class="contact-form">
        <div class="form-group">
          <label for="name">Name</label>
          <input type="text" id="name" name="name" required>
        </div>
        
        <div class="form-group">
          <label for="email">Email</label>
          <input type="email" id="email" name="_replyto" required>
        </div>
        
        <div class="form-group">
          <label for="subject">Subject</label>
          <input type="text" id="subject" name="subject" required>
        </div>
        
        <div class="form-group">
          <label for="message">Message</label>
          <textarea id="message" name="message" rows="6" required></textarea>
        </div>
        
        <!-- Hidden fields for Formspree -->
        <input type="hidden" name="_subject" value="New contact form submission from {{ site.title }}">
        
        <button type="submit" class="submit-btn" id="submit-btn">
          <span class="btn-text">Send Message</span>
          <span class="btn-loading" style="display: none;">Sending...</span>
        </button>
      </form>
      
      <div class="form-note">
        <p><small>This form uses Formspree to handle submissions. Your email will be sent directly to {{ site.email }}.</small></p>
      </div>
    </div>
  </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('contact-form');
    const status = document.getElementById('form-status');
    const submitBtn = document.getElementById('submit-btn');
    const btnText = submitBtn.querySelector('.btn-text');
    const btnLoading = submitBtn.querySelector('.btn-loading');
    
    form.addEventListener('submit', function(e) {
        e.preventDefault();
        
        // Show loading state
        submitBtn.disabled = true;
        btnText.style.display = 'none';
        btnLoading.style.display = 'inline';
        status.style.display = 'none';
        
        // Get form data
        const formData = new FormData(form);
        
        // Submit to Formspree
        fetch(form.action, {
            method: 'POST',
            body: formData,
            headers: {
                'Accept': 'application/json'
            }
        })
        .then(response => {
            if (response.ok) {
                return response.json();
            }
            throw new Error('Network response was not ok');
        })
        .then(data => {
            // Success
            status.innerHTML = `
                <div class="status-success">
                    <h3>Message Sent Successfully!</h3>
                    <p>Thank you for reaching out. I'll get back to you as soon as possible.</p>
                </div>
            `;
            status.style.display = 'block';
            
            // Clear the form with a slight delay for better UX
            setTimeout(() => {
                form.reset();
                // Also scroll to the success message
                status.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
            }, 100);
        })
        .catch(error => {
            // Error
            status.innerHTML = `
                <div class="status-error">
                    <h3>Oops! Something went wrong.</h3>
                    <p>Please try again or email me directly at {{ site.email }}</p>
                </div>
            `;
            status.style.display = 'block';
        })
        .finally(() => {
            // Reset button state
            submitBtn.disabled = false;
            btnText.style.display = 'inline';
            btnLoading.style.display = 'none';
        });
    });
});
</script>
