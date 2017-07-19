import React            from 'react';
import { connect }      from 'react-redux';
import { push }         from 'react-router-redux';
import Favicon          from 'react-favicon';
import Actions          from '../actions/sessions';
import Header           from '../layouts/header';
import { Route }        from 'react-router-dom'
import ReportsIndexView from '../views/reports'
import HomeIndexView    from '../views/home'
import {
  faviconData,
  creditsText
} from '../utils';

class AuthenticatedContainer extends React.Component {
  _renderFavicon() {
    const { timer } = this.props;

    const url = timer.started ? faviconData.on : faviconData.off;

    return (
      <Favicon url={url} />
    );
  }

  componentWillMount() {
    const { currentUser, dispatch } = this.props;

    if (!currentUser && localStorage.getItem('phoenixAuthToken')) {
      dispatch(Actions.currentUser());
    } else if (!localStorage.getItem('phoenixAuthToken')) {
      dispatch(push('/sign_in'));
    }
  }

  render() {
    const { currentUser } = this.props;

    if (!currentUser) return false;

    return (
      <div id="authentication_container" className="application-container">
        {::this._renderFavicon()}
        <Header/>

        <div className='main-container'>
          <Route exact path="/" component={HomeIndexView} />
          <Route path="/reports" component={ReportsIndexView} />
        </div>
        <footer id="main_footer">
          <div className="container">
            {creditsText()}
          </div>
        </footer>
      </div>
    );
  }
}

const mapStateToProps = (state) => ({
  currentUser: state.session.currentUser,
  socket: state.session.socket,
  channel: state.session.channel,
  timer: state.timer,
});

export default connect(mapStateToProps)(AuthenticatedContainer);
