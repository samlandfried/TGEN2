import React from "react";
import Question from "./Question";
import styles from "./Questions.module.scss";

const Questions = ({ questions }) => (
  <div className={styles.container}>
    <Question question={questions[0].question} options={questions[0].options} />
  </div>
);

export default Questions;
