import React, { useState, useEffect, useMemo } from "react";
import styles from "./Question.module.scss";

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

const Question = ({ question, options }) => {
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
              <button data-id={optionI}>{option}</button>
            </li>
          ))}
        </ol>
      </div>
    </div>
  );
};

export default Question;
