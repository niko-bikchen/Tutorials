import React, { Component } from 'react';
import Slider from 'rc-slider';
import Select from '@material-ui/core/Select';
import MenuItem from '@material-ui/core/MenuItem';
import Snackbar from '@material-ui/core/Snackbar';
import CloseIcon from '@material-ui/icons/Close';
import IconButton from '@material-ui/core/IconButton';
import { Link } from 'react-router-dom';
import 'rc-slider/assets/index.css';
import './Navbar.css';

class Navbar extends Component {
  constructor(props) {
    super(props);
    this.state = {
      format: 'hex',
      open: false,
    };

    this.handleFormatChange = this.handleFormatChange.bind(this);
    this.closeSnackbar = this.closeSnackbar.bind(this);
  }

  handleFormatChange(event) {
    this.setState({ format: event.target.value, open: true });
    this.props.handleChange(event.target.value);
  }

  closeSnackbar() {
    this.setState({ open: false });
  }

  render() {
    return (
      <div>
        <header className="Navbar">
          <div className="logo">
            <Link to="/">reactcolorpicker</Link>
          </div>
          <div className="slider-container">
            <span>Level: {this.props.level}</span>
            <div className="slider">
              <Slider
                defaultValue={this.props.level}
                min={100}
                max={900}
                step={100}
                onAfterChange={this.props.changeLevel}
              />
            </div>
          </div>
          <div className="select-container">
            <Select
              onChange={this.handleFormatChange}
              value={this.state.format}
            >
              <MenuItem value="hex">HEX - #ffffff</MenuItem>
              <MenuItem value="rgb">RGB - rgb(255, 255, 255)</MenuItem>
              <MenuItem value="rgba">RGBA - rgba(255, 255, 255, 1.0)</MenuItem>
            </Select>
          </div>
          <Snackbar
            anchorOrigin={{ vertical: 'bottom', horizontal: 'left' }}
            open={this.state.open}
            autoHideDuration={3000}
            message={
              <span id="message-id">
                Format Changed To {this.state.format.toUpperCase()}!
              </span>
            }
            ContentProps={{
              'aria-describedby': 'message-id',
            }}
            onClose={this.closeSnackbar}
            action={[
              <IconButton
                onClick={this.closeSnackbar}
                color={'inherit'}
                key="close"
                aria-label="close"
              >
                <CloseIcon />
              </IconButton>,
            ]}
          />
        </header>
      </div>
    );
  }
}

export default Navbar;
