import React, { useState, useEffect, useMemo } from "react";
import styles from "./Question.module.scss";
import utils from "../utils";

const _normalizeOptions = options => {
  const lengthOfLongestOption = options.reduce(
    (longest, current) => (current.length > longest ? current.length : longest),
    0
  );

  return options.map(option => {
    while (option.length < lengthOfLongestOption) {
      option = `${option} `;
    }

    return option;
  });
};

const _randomizeBackground = () => {
  const randomDegree = Math.floor(Math.random() * 360);
  const randomPercent = Math.floor(Math.random() * 100);
  const randomColor1 = Math.floor(Math.random() * 16777215).toString(16);
  const randomColor2 = Math.floor(Math.random() * 16777215).toString(16);
  console.log(randomColor1, randomColor2);
  document.documentElement.style.setProperty(
    "--question-bg-angle",
    `${randomDegree}deg`
  );
  document.documentElement.style.setProperty(
    "--question-bg-color-1",
    `#${randomColor1}`
  );
  document.documentElement.style.setProperty(
    "--question-bg-midpoint",
    `${randomPercent}%`
  );
  document.documentElement.style.setProperty(
    "--question-bg-color-2",
    `#${randomColor2}`
  );
};

const Question = ({ id, loadNextQuestion, question, options }) => {
  const questionWords = useMemo(() => question.split(" "), [question]);
  const blankIndex = useMemo(() => questionWords.indexOf("___"), [
    questionWords
  ]);
  const firstWordGroup = useMemo(
    () => questionWords.slice(0, blankIndex).join(" "),
    [questionWords]
  );
  const secondWordGroup = useMemo(
    () => questionWords.slice(blankIndex + 1).join(" "),
    [questionWords]
  );

  const normalizedOptions = useMemo(() => _normalizeOptions(options), [
    options
  ]);
  const BLANK = useMemo(
    () =>
      Array(normalizedOptions[0].length)
        .fill(" ")
        .join(""),
    [normalizedOptions]
  );

  const _checkAnswer = async word => {
    const response = await fetch(`/questions/${id}/check_answer`, {
      method: "post",
      body: JSON.stringify({ check_answer: { word } }),
      headers: utils.getHeaders()
    });
    const { code } = await response.json();

    if (code === "CORRECT") {
      _randomizeBackground();
      loadNextQuestion();
    }
  };

  const [formattedQuestion, setFormattedQuestion] = useState();
  const [hoveredOption, setHoveredOption] = useState(BLANK);

  useEffect(() => {
    setFormattedQuestion([
      firstWordGroup ? `${firstWordGroup} ` : "",
      <span className={styles.blank} key={hoveredOption}>
        {hoveredOption}
      </span>,
      secondWordGroup ? ` ${secondWordGroup}` : ""
    ]);
  }, [firstWordGroup, hoveredOption, secondWordGroup]);

  return (
    <div className={styles.container}>
      <div className={styles.contents}>
        <p className={styles.question}>{formattedQuestion}</p>
        <ol className={styles.options}>
          {options.map((option, optionI) => (
            <li
              key={option}
              className={styles.option}
              onMouseOver={({ target }) => {
                const index = Number(target.dataset.id);
                setHoveredOption(
                  Number.isNaN(index) ? BLANK : normalizedOptions[index]
                );
              }}
              onMouseOut={() => setHoveredOption(BLANK)}
            >
              <button
                data-id={optionI}
                data-option={option}
                onClick={({ target }) => _checkAnswer(target.dataset.option)}
              >
                {option}
              </button>
            </li>
          ))}
        </ol>
      </div>
    </div>
  );
};

export default Question;
