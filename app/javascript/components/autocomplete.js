import 'js-autocomplete/auto-complete.css';
import autocomplete from 'js-autocomplete';

const createAutocomplete = (specificSet, searchInput) => {
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

const addSpecificClass = (cssClass) => {
  const autocompletes = document.querySelectorAll('.autocomplete-suggestions');
  autocompletes.forEach((autocomplete) => {
    autocomplete.classList.add(cssClass);
  });
}

const autocompleteSearch = () => {
  const skillSets = document.querySelectorAll('.search-data-js');
  const projectFormPage = document.querySelector('.form-js');
  const userIndexPage = document.querySelector('.users-index-js');
  const projectShowPage = document.querySelector('.project-show-js');
  skillSets.forEach((set) => {
    const specificSet = JSON.parse(set.dataset.set);
    if (specificSet && projectFormPage) {
      const searchInput = set.firstElementChild.nextElementSibling;
      createAutocomplete(specificSet, searchInput);
      addSpecificClass("autocomplete-suggestions--new-project");
    } else if (specificSet && userIndexPage) {
      const searchInput = set.firstElementChild;
      console.log(searchInput)
      createAutocomplete(specificSet, searchInput);
      addSpecificClass("autocomplete-suggestions--user-index");
    } else if (specificSet && projectShowPage) {
      const searchInput = set.firstElementChild.firstElementChild.lastElementChild;
      createAutocomplete(specificSet, searchInput);
      addSpecificClass("autocomplete-suggestions--project-show");
    }
  });
};

export { autocompleteSearch };
