import React from "react";
import styles from "./Question.module.scss";

const Question = ({ question, options }) => (
  <div className={styles.container}>
    <div className={styles.contents}>
      <div className={styles.question}>{question}</div>
      <ol className={styles.options}>
        {options.map(option => (
          <li key={option} className={styles.option}>
            <button>{option}</button>
          </li>
        ))}
      </ol>
    </div>
  </div>
);

export default Question;
