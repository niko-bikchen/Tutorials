import { remove, choice } from './helpers';
import food from './food';

(function main() {
    const aFood = choice(food);
    console.log(`I'd like to have one ${aFood}, please.`);
    console.log(`Here you go: ${aFood}.`);
    console.log('Delicious! May I have another?');
    const newFood = remove(food, aFood);
    console.log(`I'm sorry, we're all out. We have ${newFood.length} other foods left.`);
    console.log(`Remaining foods: ${newFood}.`);
})();
