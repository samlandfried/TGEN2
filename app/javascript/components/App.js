import React from "react";
import Data from "./Data";
import Questions from "./Questions";

class App extends React.Component {
  render() {
    return (
      <React.Fragment>
        <Data>
          {({ questions }) =>
            questions[0] ? <Questions questions={questions} /> : "Fetching ..."
          }
        </Data>
      </React.Fragment>
    );
  }
}

export default App;
