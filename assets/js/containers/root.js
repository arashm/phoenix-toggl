import React                      from 'react';
import { Provider }               from 'react-redux';
import {
  BrowserRouter as Router,
  Route,
  Switch
} from 'react-router-dom'
import MainLayout from '../layouts/main';
import RegistrationsNewView from '../views/registrations/new'
import SessionsNewView from '../views/sessions/new'
import AuthenticatedContainer from '../containers/authenticated'

export default class Root extends React.Component {
  _ensureAuthenticated() {
    const { currentUser, dispatch } = this.props;

    if (!currentUser && localStorage.getItem('phoenixAuthToken')) {
      dispatch(Actions.currentUser());
    } else if (!localStorage.getItem('phoenixAuthToken')) {
      this.props.location.pathname = '/sign_up'
    }
  }

  render() {
    const { store } = this.props;

    return (
      <Provider store={store}>
        <MainLayout>
          <Router>
            <Switch>
              <Route path="/sign_up" component={RegistrationsNewView} />
              <Route path="/sign_in" component={SessionsNewView} />
              <Route path="/" component={AuthenticatedContainer}>
              {/* <Route path="/reports" component={ReportsIndexView} /> */}
              </Route>
              {/*
                <IndexRoute component={HomeIndexView} />
              */}
            </Switch>
          </Router>
        </MainLayout>
      </Provider>
    );
  }
}
