import React from "react";
import Data from "./Data";
import Question from "./Question";

class App extends React.Component {
  render() {
    return (
      <React.Fragment>
        <Data>
          {({ questions }) =>
            questions[0] ? (
              <Question
                sentence={questions[0].question}
                options={questions[0].options}
              />
            ) : (
              "Fetching ..."
            )
          }
        </Data>
      </React.Fragment>
    );
  }
}

export default App;
