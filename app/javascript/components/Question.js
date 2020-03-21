import React from "react";

const Question = ({ sentence, options }) => (
  <div className="question-container">
    <div className="question-sentence">{sentence}</div>
    <ol className="question-options">
      {options.map(option => (
        <li key={option} className="question-option">
          {option}
        </li>
      ))}
    </ol>
  </div>
);

export default Question;
