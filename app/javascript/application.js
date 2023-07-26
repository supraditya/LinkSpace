// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

const pasteButton = document.querySelector('#paste-button');

pasteButton.addEventListener('click', async () => {
    const text = await navigator.clipboard.readText()
   try {
     const text = await navigator.clipboard.readText()
     document.querySelector('#link-field').value += text;
     console.log('Text pasted.');
   } catch (error) {
     console.log('Failed to read clipboard');
   }
});