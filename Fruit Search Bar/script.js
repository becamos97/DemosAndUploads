const input = document.querySelector('#search-bar');
const suggestions = document.querySelector('#results-dropdown');

const fruit = ['Apple', 'Apricot', 'Avocado 🥑', 'Banana', 'Bilberry', 'Blackberry', 'Blackcurrant', 'Blueberry', 'Boysenberry', 'Currant', 'Cherry', 'Coconut', 'Cranberry', 'Cucumber', 'Custard apple', 'Damson', 'Date', 'Dragonfruit', 'Durian', 'Elderberry', 'Feijoa', 'Fig', 'Gooseberry', 'Grape', 'Raisin', 'Grapefruit', 'Guava', 'Honeyberry', 'Huckleberry', 'Jabuticaba', 'Jackfruit', 'Jambul', 'Juniper berry', 'Kiwifruit', 'Kumquat', 'Lemon', 'Lime', 'Loquat', 'Longan', 'Lychee', 'Mango', 'Mangosteen', 'Marionberry', 'Melon', 'Cantaloupe', 'Honeydew', 'Watermelon', 'Miracle fruit', 'Mulberry', 'Nectarine', 'Nance', 'Olive', 'Orange', 'Clementine', 'Mandarine', 'Tangerine', 'Papaya', 'Passionfruit', 'Peach', 'Pear', 'Persimmon', 'Plantain', 'Plum', 'Pineapple', 'Pomegranate', 'Pomelo', 'Quince', 'Raspberry', 'Salmonberry', 'Rambutan', 'Redcurrant', 'Salak', 'Satsuma', 'Soursop', 'Star fruit', 'Strawberry', 'Tamarillo', 'Tamarind', 'Yuzu'];

function search(str) {
	let results = [];

	// Converting the input to lowercase for case-insensitive search
	results = fruit.filter(fruitItem => fruitItem.toLowerCase().includes(str.toLowerCase()));


	return results;
}

function searchHandler(e) {
	const inputVal = e.target.value; //Gather current value from the input
	if (inputVal === '' ) {
		suggestions.innerHTML = '';
		suggestions.classList.remove ('has-suggestions');
		return;
	}
	console.log("User input:", inputVal);
	const results = search(inputVal); //Get search results by CALLING the search (ABOVE) function
	console.log("Search results:", results);
	showSuggestions(results, inputVal); // Update suggestions in the dropdown
}

function showSuggestions(results, inputVal) {
	suggestions.innerHTML = ''; //This is to clear previous suggestions
	console.log("showing suggestions for:", inputVal);
	if (results.length > 0 ) { 
		results.forEach(results => {
			console.log("Suggestion:", results);
			const li = document.createElement('li'); //creating a new list item
			li.textContent = results;//Setting the text content to the fruit name
			suggestions.appendChild(li);// appending the list item to the suggestions dropdown
		
		});
		suggestions.classList.add ('has-suggestions');
	} else {suggestions.classList.remove ('has-suggestions');} //this is new
}

function useSuggestion(e) {
	if (e.target.tagName === 'LI') { // Check if the clicked element is a list item
		console.log("USer selected:", e.target.textContent);
		input.value = e.target.textContent; //set the input value to the clicked suggestion
		suggestions.innerHTML = ''; //clear suggestions
		suggestions.classList.remove ('has-suggestions');
		}
}

input.addEventListener('input', searchHandler);
suggestions.addEventListener('click', useSuggestion);