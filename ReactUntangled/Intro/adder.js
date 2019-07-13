// function Adder({ n1, n2 }) {
//     const sum = n1 + n2;
//     return React.createElement('h1', {}, sum);
// }

// JSX Adder

function Adder({ n1, n2 }) {
    const sum = n1 + n2;
    return <h1>{sum}</h1>;
}

// Using a component to render elements

// ReactDOM.render(
//     React.createElement(Adder, { n1: 2, n2: 4 }),
//     document.getElementById('app')
// );

// JSX render

ReactDOM.render(<Adder n1={2} n2={4} />, document.getElementById('app'));