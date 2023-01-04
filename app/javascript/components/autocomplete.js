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
  skillSets.forEach((set) => {
    const specificSet = JSON.parse(set.dataset.set);
    if (specificSet && projectFormPage) {
      const searchInput = set.querySelector('.search-input-js');
      createAutocomplete(specificSet, searchInput);
      addSpecificClass("autocomplete-suggestions--new-project");
    }
  });
};

export { autocompleteSearch };
