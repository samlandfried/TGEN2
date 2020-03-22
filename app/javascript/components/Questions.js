import React from "react";
import Question from "./Question";
import styles from "./Questions.module.scss";

const Questions = ({ questions }) => {
  return (
    <div className={styles.container}>
      <Question {...questions[0]} />
    </div>
  );
};

export default Questions;
