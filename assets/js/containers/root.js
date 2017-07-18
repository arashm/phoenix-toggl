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
            </Switch>
          </Router>
        </MainLayout>
      </Provider>
    );
  }
}
