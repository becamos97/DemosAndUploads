const input = document.querySelector('#fruit');
const suggestions = document.querySelector('.suggestions ul');

const fruit = ['Apple', 'Apricot', 'Avocado 🥑', 'Banana', 'Bilberry', 'Blackberry', 'Blackcurrant', 'Blueberry', 'Boysenberry', 'Currant', 'Cherry', 'Coconut', 'Cranberry', 'Cucumber', 'Custard apple', 'Damson', 'Date', 'Dragonfruit', 'Durian', 'Elderberry', 'Feijoa', 'Fig', 'Gooseberry', 'Grape', 'Raisin', 'Grapefruit', 'Guava', 'Honeyberry', 'Huckleberry', 'Jabuticaba', 'Jackfruit', 'Jambul', 'Juniper berry', 'Kiwifruit', 'Kumquat', 'Lemon', 'Lime', 'Loquat', 'Longan', 'Lychee', 'Mango', 'Mangosteen', 'Marionberry', 'Melon', 'Cantaloupe', 'Honeydew', 'Watermelon', 'Miracle fruit', 'Mulberry', 'Nectarine', 'Nance', 'Olive', 'Orange', 'Clementine', 'Mandarine', 'Tangerine', 'Papaya', 'Passionfruit', 'Peach', 'Pear', 'Persimmon', 'Plantain', 'Plum', 'Pineapple', 'Pomegranate', 'Pomelo', 'Quince', 'Raspberry', 'Salmonberry', 'Rambutan', 'Redcurrant', 'Salak', 'Satsuma', 'Soursop', 'Star fruit', 'Strawberry', 'Tamarillo', 'Tamarind', 'Yuzu'];

function search(str) {
	let results = [];

	// Converting the input to lowercase for case-insensitive search
	results = fruit.filter(fruitItem => fruitItem.toLowerCase().includes(str.toLowerCase()));


	return results;
}

function searchHandler(e) {
	const inputVal = e.target.value; //Gather current value from the input
	const results = search(inputVal); //Get search results by CALLING the search (ABOVE) function
	showSuggestions(results, inputVal); // Update suggestions in the dropdown
}

function showSuggestions(results, inputVal) {
	suggestions.innerHTML = ''; //This is to clear previous suggestions
	
	results.forEach(results => {
		const li = document.createElement('li'); //creating a new list item
		li.textContent = result;//Setting the text content to the fruit name
		suggestions.appendChild(li);// appending the list item to the suggestions dropdown
	
	});
}

function useSuggestion(e) {
	if (e.target.tagName === 'LI') { // Check if the clicked element is a list item
		input.value = e.target.textContent; //set the input value to the clicked suggestion
		suggestions.innerHTML = ''; //clear suggestions
		}
}

input.addEventListener('keyup', searchHandler);
suggestions.addEventListener('click', useSuggestion);