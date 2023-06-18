import {useDispatch} from 'react-redux'

import {FaRegPaperPlane} from 'react-icons/fa'
import {BsFillTelephoneFill} from 'react-icons/bs'
import {GrMail} from 'react-icons/gr'

// import from '../modals/CheckStatusModal';
import {NEW_REQUEST_MODAL_ID} from '../../modals/NewRequestModal/NewRequestModal';
import {ModalLayout} from '../../modals/ModalLayout/ModalLayout'

import {Header} from '../../containers/Header/Header';
import {Footer} from '../../components/Footer/Footer';
import {Question} from '../../components/Question/Question';

import landingStyles from './Landing.module.css';
import shortInfoStyles from './ShortInfo.module.css';
import faqStyles from './FAQ.module.css';
import contactsStyles from './Contacts.module.css';

import {openModal} from "../../redux/slices/modalSlice";

const questions = [
    {
        question: 'Как обрабатывается заявка?',
        answer: 'После того, как Вы подали заявку наш менеджер берёт её в работу, направляет её на следующий отдел.',
    },
    {
        question: 'Срок обработки заявки?',
        answer: 'На решение заявки у нас уходит от 1 до 3 дней, но в некоторых случаях нам может потребоваться чуть больше времени.',
    },
    {
        question: 'Не работает лояльность',
        answer: 'Если у Вас не работает лояльность, то необходимо написать/позвонить нашему менеджеру для быстрого решения.',
    },
]

export function Landing() {
    const dispatch = useDispatch();

    return (
        <>
            <Header/>
            <div className={landingStyles.landing}>

                <section className={shortInfoStyles.shortInfo}>
                    <h1>
                        Платформа лояльности и управления потребительским опытом
                    </h1>
                    <button
                        onClick={() => {
                            dispatch(openModal(NEW_REQUEST_MODAL_ID));
                            // showAlert('he')
                        }}
                    >
                        Оставить заявку
                    </button>
                    <img
                        src="/static/phone_example.png"
                        alt="phone example"
                    />
                </section>

                <a name="faq"/>
                <section className={faqStyles.faq}>
                    <h1>
                        Часто задаваемые вопросы
                    </h1>
                    <div>
                        {questions.map((item, index) =>
                            <Question
                                key={index}
                                question={item.question}
                                answer={item.answer}
                            />
                        )}
                    </div>
                </section>

                <a name="contacts"/>
                <section className={contactsStyles.contacts}>
                    <h1>
                        Контакты
                    </h1>
                    <div>
                        <div>
                            <GrMail/>
                            <a href='mailto:Maxbonus.info@gmail.com'>
                                Maxbonus.info@gmail.com
                            </a>

                        </div>
                        <div>
                            <BsFillTelephoneFill/>
                            <a href='tel:+79135074577'>
                                +7 913 507 4577
                            </a>

                        </div>


                    </div>
                </section>
            </div>
            <Footer/>

            <ModalLayout/>
        </>
    );
}

