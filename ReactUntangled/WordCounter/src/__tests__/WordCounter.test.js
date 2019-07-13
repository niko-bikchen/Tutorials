import React from 'react';
import { shallow } from 'enzyme';
import WordCounter from '../WordCounter';
import countWords from '../countWords';
import Counter from '../Counter';
import Editor from '../Editor';
import ProgressBar from '../ProgressBar';
import Enzyme from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

Enzyme.configure({ adapter: new Adapter() });

describe('When I type some words', () => {
    const target = 10;
    const inputString = 'One Two Three Four';
    const wordCounter = shallow(<WordCounter targetWordCount={target} />);

    const textarea = wordCounter.find(Editor).dive().find('textarea');
    textarea.simulate('change', { target: { value: inputString } });

    it('disaplays the correct count as a number', () => {
        const counter = wordCounter.find(Counter);
        expect(counter.prop('count')).toBe(countWords(inputString));
    });

    it('displays the corrct progress', () => {
        const progressBar = wordCounter.find('ProgressBar');
        expect(progressBar.prop('completion')).toBe(countWords(inputString) / target);
    });
});