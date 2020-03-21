import React from "react";
import Data from "./Data";

class App extends React.Component {
  render() {
    return (
      <React.Fragment>
        <Data>
          {({ questions }) =>
            questions[0] ? JSON.stringify(questions[0]) : "Fetching ..."
          }
        </Data>
      </React.Fragment>
    );
  }
}

export default App;
