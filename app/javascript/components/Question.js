import React from "react";
import styles from "./Question.module.scss";

const Question = ({ sentence, options }) => (
  <div className={styles.container}>
    Question:
    <div className={styles.sentence}>{sentence}</div>
    <ol className={styles.options}>
      {options.map(option => (
        <li key={option} className={styles.option}>
          {option}
        </li>
      ))}
    </ol>
  </div>
);

export default Question;
