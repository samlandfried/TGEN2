import React from "react";
import styles from "./Question.module.scss";

const Question = ({ question, options }) => (
  <div className={styles.container}>
    <div className={styles.question}>{question}</div>
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