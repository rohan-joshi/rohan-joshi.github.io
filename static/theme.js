// Theme management for light/dark mode toggle
(function() {
  'use strict';

  // Get current theme from localStorage or default to 'light'
  function getTheme() {
    return localStorage.getItem('theme') || 'light';
  }

  // Set theme on document and save to localStorage
  function setTheme(theme) {
    document.documentElement.setAttribute('data-theme', theme);
    localStorage.setItem('theme', theme);
    updateThemeIcon(theme);
  }

  // Update the theme toggle button icon
  function updateThemeIcon(theme) {
    const icon = document.querySelector('#theme-toggle .theme-icon');
    if (icon) {
      icon.textContent = theme === 'dark' ? '☀' : '☾';
    }
  }

  // Toggle between light and dark themes
  function toggleTheme() {
    const currentTheme = getTheme();
    const newTheme = currentTheme === 'light' ? 'dark' : 'light';
    setTheme(newTheme);
  }

  // Initialize theme on page load
  function initTheme() {
    const theme = getTheme();
    updateThemeIcon(theme);

    // Add click event listener to theme toggle button
    const toggleButton = document.getElementById('theme-toggle');
    if (toggleButton) {
      toggleButton.addEventListener('click', toggleTheme);
    }

    // Optional: Add keyboard shortcut (Ctrl/Cmd + D)
    document.addEventListener('keydown', function(e) {
      if ((e.ctrlKey || e.metaKey) && e.key === 'd') {
        e.preventDefault();
        toggleTheme();
      }
    });
  }

  // Run initialization when DOM is ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initTheme);
  } else {
    initTheme();
  }
})();
