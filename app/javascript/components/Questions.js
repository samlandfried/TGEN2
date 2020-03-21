import React from "react";
import Question from "./Question";

const Questions = ({ questions }) => (
  <Question question={questions[0].question} options={questions[0].options} />
);

export default Questions;
