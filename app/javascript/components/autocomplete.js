import 'js-autocomplete/auto-complete.css';
import autocomplete from 'js-autocomplete';


function createAutocomplete(specificSet, searchInput) {
  new autocomplete({
    selector: searchInput,
    minChars: 1,
    source: function(term, suggest){
        term = term.toLowerCase();
        const choices = specificSet;
        const matches = [];
        for (let i = 0; i < choices.length; i++)
            if (~choices[i].toLowerCase().indexOf(term))
              matches.push(choices[i]);
              suggest(matches.slice(0, specificSet.length));
    },
  });
}
function addSpecificClass(cssClass) {
  const autocompletes = document.querySelectorAll('.autocomplete-suggestions');
  autocompletes.forEach((autocomplete) => {
    autocomplete.classList.add(cssClass);
  });
}
const autocompleteSearch = function() {
  const skill_sets = document.querySelectorAll('.search-data');
  const formPage = document.querySelector('.new-project-js');
  const searchUserPage = document.querySelector('.users-index-js');
  const projectPage = document.querySelector('.project-show-js');
  skill_sets.forEach((set) => {
    const specificSet = JSON.parse(set.dataset.set);
    if (specificSet && formPage) {
      const searchInput = set.firstElementChild.nextElementSibling;
      createAutocomplete(specificSet, searchInput);
      addSpecificClass("autocomplete-suggestions-form");
    } else if (specificSet && searchUserPage) {
      const searchInput = set.firstElementChild.nextElementSibling;
      createAutocomplete(specificSet, searchInput);
      addSpecificClass("autocomplete-suggestions-search");
    } else if (specificSet && projectPage) {
      const searchInput = set.firstElementChild.firstElementChild.lastElementChild;
      createAutocomplete(specificSet, searchInput);
      addSpecificClass("autocomplete-suggestions-project");
    }
  });

};

export { autocompleteSearch };
