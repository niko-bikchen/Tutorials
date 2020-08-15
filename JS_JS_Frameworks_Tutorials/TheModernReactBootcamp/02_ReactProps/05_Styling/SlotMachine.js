class SlotMachine extends React.Component {
    render() {
        const slotPics = this.props.slotPics;
        let spinResult = [];

        for (let i = 0; i < slotPics.length; i += 1) {
            spinResult.push(
                slotPics[Math.floor(Math.random() * slotPics.length)]
            );
        }

        let message = spinResult.every((item) => item === spinResult[0])
            ? 'You Win 🎉'
            : 'You Lose 😬';

        return (
            <div className="SlotMachine">
                <p style={{ fontSize: '24px', backgroundColor: 'lightgreen' }}>
                    {spinResult.join('')}
                </p>
                <p>{message}</p>
            </div>
        );
    }
}
