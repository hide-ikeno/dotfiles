"""Converter to prepend devicons to denite candidates."""
from pathlib import Path

from denite.base.filter import Base

DEFAULT_ICON = ''
DIR_ICON = ''
FILENAMES = {
    '.bash_profile': '',
    '.bashrc': '',
    '.ds_store': '',
    '.gitconfig': '',
    '.gitignore': '',
    '.gitlab-ci.yml': '',
    '.gvimrc': '',
    '.vimrc': '',
    '.zshrc': '',
    '_vimrc': '',
    '_gvimrc': '',
    'dockerfile': '',
    'docker-compose.yml': '',
    'dropbox': '',
    'favicon.ico': '',
    'gruntfile.coffee': '',
    'gruntfile.js': '',
    'gruntfile.ls': '',
    'gulpfile.coffee': '',
    'gulpfile.js': '',
    'gulpfile.ls': '',
    'license': '',
    'mix.lock': '',
    'node_modules': '',
    'procfile': '',
    'react.jsx': '',
    'requirements.txt': '',
}
EXTENSIONS = {
    '.ai': '',
    '.awk': '',
    '.bash': '',
    '.bat': '',
    '.bmp': '',
    '.c': '',
    '.cc': '',
    '.clj': '',
    '.cljc': '',
    '.cljs': '',
    '.coffee': '',
    '.conf': '',
    '.cp': '',
    '.cpp': '',
    '.cs': '',
    '.csh': '',
    '.css': '',
    '.cxx': '',
    '.c++': '',
    '.d': '',
    '.dart': '',
    '.db': '',
    '.diff': '',
    '.dump': '',
    '.edn': '',
    '.eex': '',
    '.ejs': '',
    '.elm': '',
    '.erl': '',
    '.ex': '',
    '.exs': '',
    '.f#': '',
    '.fish': '',
    '.fs': '',
    '.fsi': '',
    '.fsscript': '',
    '.fsx': '',
    '.gif': '',
    '.go': '',
    '.h': '',
    '.hbs': '',
    '.hh': '',
    '.hpp': '',
    '.hrl': '',
    '.hs': '',
    '.htm': '',
    '.html': '',
    '.hxx': '',
    '.ico': '',
    '.ini': '',
    '.java': '',
    '.jl': '',
    '.jpeg': '',
    '.jpg': '',
    '.js': '',
    '.json': '',
    '.jsx': '',
    '.ksh': '',
    '.leex': '',
    '.less': '',
    '.lhs': '',
    '.lua': '',
    '.markdown': '',
    '.md': '',
    '.mdx': '',
    '.mjs': '',
    '.ml': 'λ',
    '.mli': 'λ',
    '.mustache': '',
    '.pdf': '',
    '.php': '',
    '.pl': '',
    '.pm': '',
    '.png': '',
    '.pp': '',
    '.ps1': '',
    '.psb': '',
    '.psd': '',
    '.py': '',
    '.pyc': '',
    '.pyd': '',
    '.pyo': '',
    '.r': 'ﳒ',
    '.R': 'ﳒ',
    '.rb': '',
    '.rlib': '',
    '.rmd': '',
    '.rs': '',
    '.rss': '',
    '.sass': '',
    '.scala': '',
    '.scss': '',
    '.sh': '',
    '.slim': '',
    '.sln': '',
    '.sql': '',
    '.styl': '',
    '.suo': '',
    '.swift': '',
    '.t': '',
    '.tex': '',
    '.toml': '',
    '.ts': '',
    '.tsx': '',
    '.txt': '',
    '.twig': '',
    '.vim': '',
    '.vue': '﵂',
    '.xcplayground': '',
    '.xul': '',
    '.yaml': '',
    '.yml': '',
    '.zsh': '',
}


class Filter(Base):
    """Prepend devicons to denite candidate files."""

    def __init__(self, vim):
        super().__init__(vim)
        self.name = 'converter/devicons'
        self.description = 'Prepend devicons to denite candidate files'

    def _get_icon(self, filename):
        filename = Path(filename)
        if filename.is_dir():
            return DIR_ICON

        basefile = filename.stem.lower()
        extension = filename.suffix
        if basefile in FILENAMES:
            return FILENAMES[basefile]
        elif extension in EXTENSIONS:
            return EXTENSIONS[extension]
        else:
            return DEFAULT_ICON

    def filter(self, context):
        """Parse candidates and prepend devicons."""
        for i, candidate in enumerate(context['candidates']):
            if i > 25:
                break

            if 'word' in candidate and 'action__path' in candidate:
                filename = candidate['action__path']
                icon = self._get_icon(filename)
                if icon not in candidate.get('abbr', '')[:10]:
                    candidate[
                        'abbr'
                    ] = f" {icon} {candidate.get('abbr', candidate['word'])}"

        return context['candidates']

