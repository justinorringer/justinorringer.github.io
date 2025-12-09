# justinorringer.com

Personal website built with Jekyll and hosted on GitHub Pages.

## Development Setup

### Environment Variables

This site uses Cloudinary for image hosting. The Cloudinary cloud name is configured in `_config.yml`. 

For local development, you can override the cloud name by setting:
```bash
export CLOUDINARY_CLOUD_NAME=your_cloud_name
```

Or create a `.env` file (optional):
```bash
cp .env.example .env
# Edit .env with your cloud name if different from default
```

### Local Development

Build the site:
```bash
bundle exec jekyll build
```

Serve the site locally:
```bash
bundle exec jekyll serve
```

The site will be available at `http://localhost:4000` with live reload enabled.

### Deployment

The site automatically deploys to GitHub Pages when changes are pushed to the `main` branch. No additional secrets are required as the Cloudinary configuration is set in the `_config.yml` file.

## Features

- Photography gallery with Cloudinary integration
- Project showcase
- Contact form with Formspree
- Responsive design inspired by Daido Moriyama's aesthetic
- Full-screen swipeable gallery with lazy loading
