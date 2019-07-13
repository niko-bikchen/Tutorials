import React from 'react';
import Pikaday from 'pikaday';

class DatePicker extends React.Component {
    render() {
        return (
            <input ref={input => this.el = input} />
        )
    }

    componentDidMount() {
        const el = this.el;
        const { onSelect } = this.props;
        this.picker = new Pikaday({
            field: el,
            onSelect
        });
    }

    componentWillUnmount() {
        this.picker.destroy();
    }
}

export default DatePicker;